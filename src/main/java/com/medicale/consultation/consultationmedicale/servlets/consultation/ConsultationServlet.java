package com.medicale.consultation.consultationmedicale.servlets.consultation;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.enums.TicketStatus;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.services.*;
import com.medicale.consultation.consultationmedicale.services.user.PatientService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet("/dashboard/consultations")
public class ConsultationServlet extends BaseServlet {
    private PatientService patientService;
    private MedicaleFileService medicaleFileService;
    private ConsultationService consultationService;
    private MedicaleActService medicaleActService;
    private TicketService ticketService;
    private SpecialistService specialistService;

    @Override
    public void init() {
        this.patientService = new PatientService(JPAUtils.getEntityManager());
        this.medicaleFileService = new MedicaleFileService(JPAUtils.getEntityManager());
        this.consultationService = new ConsultationService(JPAUtils.getEntityManager());
        this.medicaleActService = new MedicaleActService(JPAUtils.getEntityManager());
        this.ticketService = new TicketService(JPAUtils.getEntityManager());
        this.specialistService = new SpecialistService(JPAUtils.getEntityManager());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get patientId from query parameter
        String patientIdParam = request.getParameter("patientId");

        if (patientIdParam == null || patientIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            int patientId = Integer.parseInt(patientIdParam);

            // Get patient from DB
            Patient patient = patientService.findById(patientId);
            if (patient == null) {
                request.setAttribute("errorMessage", "Patient introuvable !");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            Generalist generalist = (Generalist) getUser(request);
            List<Specialist> specialists = specialistService.getAllSpecialists();

            // VÉRIFIER SI UNE CONSULTATION EN ATTENTE EXISTE DÉJÀ
            Consultation existingConsultation = consultationService.findPendingConsultationByPatientAndGeneralist(
                    patientId, generalist.getId()
            );

            Consultation consultation;

            if (existingConsultation != null) {
                // Utiliser la consultation existante
                consultation = existingConsultation;
                System.out.println("Consultation en attente trouvée, réutilisation: " + consultation.getId());
            } else {
                // Créer une nouvelle consultation
                MedicaleFile medicalFile = medicaleFileService.findByPatientId(patientId);

                consultation = new Consultation();
                consultation.setCreatedAt(LocalDateTime.now());
                consultation.setConsultationStatus(ConsultationStatus.WAITING);
                consultation.setFeedback("");
                consultation.setMedicaleFile(medicalFile);
                consultation.setMedicaleActs(Collections.emptyList());
                consultation.setGeneralist(generalist);
                consultation.setTotalPrice(generalist.getFee());

                consultationService.create(consultation);
                System.out.println("Nouvelle consultation créée: " + consultation.getId());
            }

            // Pass data to JSP
            request.setAttribute("patient", patient);
            request.setAttribute("medicalFile", consultation.getMedicaleFile());
            request.setAttribute("consultation", consultation);
            request.setAttribute("specialists", specialists);

            // Forward to JSP page
            request.getRequestDispatcher("/WEB-INF/views/consultation/consultationDetails.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID du patient invalide !");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // --- Récupération des données du formulaire ---
            String consultationIdParam = request.getParameter("consultationId");
            String[] selectedActs = request.getParameterValues("medicalActs");
            String feedback = request.getParameter("feedback");
            String action = request.getParameter("action");

            int consultationId = Integer.parseInt(consultationIdParam);
            System.out.println("consultationId: " + consultationId);

            // --- Récupération de la consultation ---
            Consultation consultation = consultationService.getConsultationById(consultationId);
            if (consultation == null) {
                request.setAttribute("error", "Consultation not found!");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // --- Gestion des actes médicaux sélectionnés ---
            Set<MedicaleAct> acts = new HashSet<>();
            double totalPrice = ((Generalist) getUser(request)).getFee();

            if (selectedActs != null) {
                for (String actIdStr : selectedActs) {
                    if (!actIdStr.isEmpty()) {
                        int actId = Integer.parseInt(actIdStr);
                        MedicaleAct act = medicaleActService.findById(actId);
                        if (act != null) {
                            acts.add(act);
                            totalPrice += act.getPrice();
                        }
                    }
                }
            }

            // --- Si l’action est de terminer la consultation ---
            if ("complete".equals(action)) {
                consultation.setFeedback(feedback);
                consultation.setMedicaleActs(new ArrayList<>(acts));
                consultation.setConsultationStatus(ConsultationStatus.COMPLETED);
                consultation.setTotalPrice(totalPrice);

                // --- Persister les changements ---
                consultationService.update(consultation);

                List<Ticket> tickets = consultation.getMedicaleFile().getPatient().getTickets();
                Ticket ticket = tickets.get(tickets.size() - 1);

                ticket.setStatus(TicketStatus.COMPLETED);
                ticketService.update(ticket);

                request.setAttribute("message", "Consultation completed successfully!");
                request.setAttribute("consultation", consultation);
                request.setAttribute("totalPrice", totalPrice);
                request.getRequestDispatcher("/WEB-INF/views/consultation/success.jsp").forward(request, response);

            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
