package com.medicale.consultation.consultationmedicale.servlets.patient;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.enums.Gender;
import com.medicale.consultation.consultationmedicale.enums.Role;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.services.user.PatientService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/addPatient")
public class AddPatientServlet extends BaseServlet {
    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.patientService = new PatientService(JPAUtils.getEntityManager());
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/patient/addPatient.jsp").forward(req, resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String dateOfBirthStr = req.getParameter("dateOfBirth");
            LocalDate dateOfBirth = LocalDate.parse(dateOfBirthStr);

            Patient patient = patientService.create(
                    req.getParameter("firstName"),
                    req.getParameter("lastName"),
                    null,
                    "",
                    req.getParameter("phone"),
                    Gender.MALE,
                    Role.PATIENT,
                    UUID.randomUUID().toString(),
                    dateOfBirth,
                    Double.parseDouble(req.getParameter("height")),
                    Double.parseDouble(req.getParameter("weight"))
            );

            resp.sendRedirect(req.getContextPath() + "/addMedicaleFile?patientId=" + patient.getId());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
        }
    }
}

// problem: patient not added to database, fix redirection