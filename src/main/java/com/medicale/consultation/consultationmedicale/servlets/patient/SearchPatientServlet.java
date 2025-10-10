package com.medicale.consultation.consultationmedicale.servlets.patient;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.repositories.PatientRepository;
import com.medicale.consultation.consultationmedicale.services.user.PatientService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/searchPatient")
public class SearchPatientServlet extends BaseServlet {
    private final PatientService patientService = new PatientService(JPAUtils.getEntityManager());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        if (name != null && !name.isEmpty()) {
            Patient patient = patientService.findByFirstAndLastName(name);

            request.setAttribute("patient", patient);
        }

        request.getRequestDispatcher("/WEB-INF/views/nurse/dashboard.jsp").forward(request, response);
    }
}
