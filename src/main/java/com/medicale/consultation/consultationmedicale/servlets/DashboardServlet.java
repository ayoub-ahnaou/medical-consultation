package com.medicale.consultation.consultationmedicale.servlets;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.Agenda;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.Request;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.models.person.Person;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.services.ConsultationService;
import com.medicale.consultation.consultationmedicale.services.RequestService;
import com.medicale.consultation.consultationmedicale.services.SpecialistService;
import com.medicale.consultation.consultationmedicale.services.TicketService;
import com.medicale.consultation.consultationmedicale.services.user.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends BaseServlet{
    private TicketService  ticketService;
    private PatientService patientService;
    private SpecialistService specialistService;
    private ConsultationService consultationService;
    private RequestService requestService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.ticketService = new TicketService(JPAUtils.getEntityManager());
        this.patientService = new PatientService(JPAUtils.getEntityManager());
        this.specialistService = new SpecialistService(JPAUtils.getEntityManager());
        this.consultationService = new ConsultationService(JPAUtils.getEntityManager());
        this.requestService = new RequestService(JPAUtils.getEntityManager());
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Person currentUser = (Person) req.getSession().getAttribute("user");

        String role = session.getAttribute("userRole").toString();

        switch (role) {
            case "NURSE" -> {
                List<Patient> patients = patientService.findAll();
                req.setAttribute("patients", patients);
                req.getRequestDispatcher("/WEB-INF/views/nurse/dashboard.jsp").forward(req, resp);
            }
            case "GENERALIST" -> {
                try {
                    List<Ticket> tickets = ticketService.findAllByDateDesc();
                    req.setAttribute("tickets", tickets);
                    // Récupérer les consultations du médecin
                    List<Consultation> consultations = consultationService.getConsultationsByDoctor((int) session.getAttribute("userId"));
                    req.setAttribute("consultations", consultations);

                    // Récupérer les demandes d'expertise
                    List<Request> requests = requestService.getRequestsByGeneralist(currentUser.getId());
                    req.setAttribute("requests", requests);
                    req.getRequestDispatcher("/WEB-INF/views/generalist/dashboard.jsp").forward(req, resp);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            case "SPECIALIST" ->{
                int specialistId = (int) session.getAttribute("userId");
                Specialist specialist = specialistService.getSpecialistById(specialistId);
                List<Agenda> agendas = specialist.getAgendas();
                List<Request> requests = specialist.getRequests();

                req.setAttribute("agendas", agendas);
                req.setAttribute("requests", requests);

                req.getRequestDispatcher("/WEB-INF/views/specialist/dashboard.jsp").forward(req, resp);
            }
            default -> resp.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }
}
