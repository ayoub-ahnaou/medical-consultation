package com.medicale.consultation.consultationmedicale.servlets;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.repositories.MedicaleFileRepository;
import com.medicale.consultation.consultationmedicale.services.MedicaleFileService;
import com.medicale.consultation.consultationmedicale.services.user.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/addMedicaleFile")
public class AddMedicaleFileServlet extends BaseServlet {

    private MedicaleFileService medicaleFileService;
    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.medicaleFileService = new MedicaleFileService(new MedicaleFileRepository(JPAUtils.getEntityManager()));
        this.patientService = new PatientService(JPAUtils.getEntityManager());

        System.out.println("AddMedicaleFileServlet loaded");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String patientIdParam = req.getParameter("patientId");
        if (patientIdParam != null) {
            int patientId = Integer.parseInt(patientIdParam);
            Patient patient = patientService.findById(patientId);
            req.setAttribute("patient", patient);
        }
        render(req, resp, "patient/addMedicaleFile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int patientId = Integer.parseInt(req.getParameter("patientId"));
            Patient patient = patientService.findById(patientId);

            MedicaleFile file = new MedicaleFile();
            file.setPatient(patient);
            file.setTemperature(Double.parseDouble(req.getParameter("temperature")));
            file.setPulse(Integer.parseInt(req.getParameter("pulse")));
            file.setBloodPresure(Integer.parseInt(req.getParameter("bloodPresure")));
            file.setRespiratoryRate(Integer.parseInt(req.getParameter("respiratoryRate")));
            file.setOxygenSaturation(Double.parseDouble(req.getParameter("oxygenSaturation")));
            file.setPain(Integer.parseInt(req.getParameter("pain")));

            medicaleFileService.create(file);

            req.setAttribute("success", "Dossier médical ajouté avec succès !");
            resp.sendRedirect(req.getContextPath() + "/dashboard"); // redirect after saving
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            render(req, resp, "/WEB-INF/views/patient/addMedicaleFile.jsp");
        }
    }
}
