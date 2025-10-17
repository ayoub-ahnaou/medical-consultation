package com.medicale.consultation.consultationmedicale.servlets.agenda;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.models.Agenda;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.services.AgendaService;
import com.medicale.consultation.consultationmedicale.services.SpecialistService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard/specialists/agenda")
public class SpecialistAgendaServlet extends BaseServlet {
    private AgendaService agendaService;
    private SpecialistService specialistService;

    @Override
    public void init() {
        this.agendaService = new AgendaService(JPAUtils.getEntityManager());
        this.specialistService = new SpecialistService(JPAUtils.getEntityManager());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Integer specialistId = (Integer) session.getAttribute("specialistId");

        if (specialistId == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Specialist not logged in");
            return;
        }

        List<Agenda> agendas = agendaService.getAllAgenda();
        req.setAttribute("agendas", agendas);
        req.getRequestDispatcher("/WEB-INF/views/specialist/list_agenda.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Récupération des paramètres
            String referenceDateStr = req.getParameter("referenceDate");
            String startTimeStr = req.getParameter("startTime");
            String endTimeStr = req.getParameter("endTime");
            String slotDurationStr = req.getParameter("slotDuration");
            String[] days = req.getParameterValues("days");
            String specialistIdStr = req.getParameter("specialistId");

            // Validation des paramètres obligatoires
            if (referenceDateStr == null || startTimeStr == null || endTimeStr == null ||
                    slotDurationStr == null || days == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
                return;
            }

            LocalDate referenceDate;
            LocalTime startTime;
            LocalTime endTime;
            int slotDurationMinutes;

            // Parsing sécurisé
            try {
                referenceDate = LocalDate.parse(referenceDateStr);
                startTime = LocalTime.parse(startTimeStr);
                endTime = LocalTime.parse(endTimeStr);
                slotDurationMinutes = Integer.parseInt(slotDurationStr);
            } catch (DateTimeParseException | NumberFormatException e) {
                req.setAttribute("error", "Invalid date, time, or duration format.");
                req.getRequestDispatcher("/WEB-INF/views/specialist/dashboard.jsp").forward(req, resp);
                return;
            }

            if (!endTime.isAfter(startTime)) {
                req.setAttribute("error", "End time must be after start time.");
                req.getRequestDispatcher("/WEB-INF/views/specialist/dashboard.jsp").forward(req, resp);
                return;
            }

            if (slotDurationMinutes <= 0) {
                req.setAttribute("error", "Slot duration must be positive.");
                req.getRequestDispatcher("/WEB-INF/views/specialist/dashboard.jsp").forward(req, resp);
                return;
            }

            // Récupération du spécialiste
            HttpSession session = req.getSession(false);
            if ((specialistIdStr == null || specialistIdStr.isEmpty()) && session != null) {
                specialistIdStr = String.valueOf(session.getAttribute("specialistId"));
            }

            if (specialistIdStr == null || specialistIdStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Specialist not identified.");
                return;
            }

            int specialistId = Integer.parseInt(specialistIdStr);
            Specialist specialist = specialistService.getSpecialistById(specialistId);
            if (specialist == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Specialist not found.");
                return;
            }

            // Conversion des jours sélectionnés
            List<DayOfWeek> selectedDays = new ArrayList<>();
            for (String d : days) {
                selectedDays.add(DayOfWeek.valueOf(d));
            }

            // Appel du service pour générer et enregistrer les créneaux
            agendaService.createWeeklyAgenda(
                    specialist,
                    referenceDate,   // on passe la date de référence
                    startTime,
                    endTime,
                    slotDurationMinutes,
                    selectedDays
            );

            // Succès : message + redirection
            req.getSession().setAttribute("message",
                    "Agenda successfully created for the week of " + referenceDate);
            resp.sendRedirect(req.getContextPath() + "/specialist/agenda/list");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
