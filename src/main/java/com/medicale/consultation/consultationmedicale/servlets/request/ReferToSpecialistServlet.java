package com.medicale.consultation.consultationmedicale.servlets.request;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.services.ConsultationService;
import com.medicale.consultation.consultationmedicale.services.SpecialistService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/consultation/refer")
public class ReferToSpecialistServlet extends BaseServlet {
    private SpecialistService specialistService;
    private ConsultationService consultationService;

    @Override
    public void init() throws ServletException {
        specialistService = new SpecialistService(JPAUtils.getEntityManager());
        consultationService = new ConsultationService(JPAUtils.getEntityManager());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int consultationId = Integer.parseInt(request.getParameter("consultationId"));
        int generalistId = Integer.parseInt(request.getParameter("generalistId"));

        // Charger les spécialistes disponibles
        List<Specialist> specialists = specialistService.getAllSpecialists();

        request.setAttribute("consultationId", consultationId);
        request.setAttribute("generalistId", generalistId);
        request.setAttribute("specialists", specialists);

        request.getRequestDispatcher("/WEB-INF/views/consultation/refer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int consultationId = Integer.parseInt(request.getParameter("consultationId"));
        int generalistId = Integer.parseInt(request.getParameter("generalistId"));
        int specialistId = Integer.parseInt(request.getParameter("specialistId"));
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        LocalTime time = LocalTime.parse(request.getParameter("time"));
        String description = request.getParameter("description");

        // Combine date and time into LocalDateTime
        LocalDateTime datetime = LocalDateTime.of(date, time);

        // Call your service to refer the consultation
        consultationService.referToSpecialist(consultationId, generalistId, specialistId, datetime, description);

        response.sendRedirect(request.getContextPath() + "/dashboard?success=1");
    }

}
