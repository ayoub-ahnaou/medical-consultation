package com.medicale.consultation.consultationmedicale.servlets.patient;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.repositories.MedicaleFileRepository;
import com.medicale.consultation.consultationmedicale.services.MedicaleFileService;
import com.medicale.consultation.consultationmedicale.services.TicketService;
import com.medicale.consultation.consultationmedicale.services.user.PatientService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/addMedicaleFile")
public class AddMedicaleFileServlet extends BaseServlet {

    private MedicaleFileService medicaleFileService;
    private PatientService patientService;
    private TicketService ticketService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.medicaleFileService = new MedicaleFileService(new MedicaleFileRepository(JPAUtils.getEntityManager()));
        this.patientService = new PatientService(JPAUtils.getEntityManager());
        this.ticketService = new TicketService(JPAUtils.getEntityManager());
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
            // check if medical file already exists for this patient
            MedicaleFile medicaleFile = medicaleFileService.findByPatientId(patientId);

            if(medicaleFile != null){
                medicaleFile.setTemperature(Double.parseDouble(req.getParameter("temperature")));
                medicaleFile.setPulse(Integer.parseInt(req.getParameter("pulse")));
                medicaleFile.setBloodPresure(Integer.parseInt(req.getParameter("bloodPresure")));
                medicaleFile.setRespiratoryRate(Integer.parseInt(req.getParameter("respiratoryRate")));
                medicaleFile.setOxygenSaturation(Double.parseDouble(req.getParameter("oxygenSaturation")));
                medicaleFile.setPain(Integer.parseInt(req.getParameter("pain")));

                medicaleFileService.update(medicaleFile);
                req.setAttribute("success", "Dossier médical mis à jour avec succès !");
            } else {
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
            }
            // create a ticket for current patient juste inserted
            ticketService.createTicketForPatient(patient);

            resp.sendRedirect(req.getContextPath() + "/dashboard"); // redirect after saving
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            render(req, resp, "/WEB-INF/views/patient/addMedicaleFile.jsp");
        }
    }
}
