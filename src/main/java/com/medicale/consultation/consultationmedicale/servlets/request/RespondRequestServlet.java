package com.medicale.consultation.consultationmedicale.servlets.request;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.enums.RequestStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.Request;
import com.medicale.consultation.consultationmedicale.services.ConsultationService;
import com.medicale.consultation.consultationmedicale.services.RequestService;
import com.medicale.consultation.consultationmedicale.servlets.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/request/respond")
public class RespondRequestServlet extends BaseServlet {
    private RequestService requestService;
    private ConsultationService consultationService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.requestService = new RequestService(JPAUtils.getEntityManager());
        this.consultationService = new ConsultationService(JPAUtils.getEntityManager());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int requestId = Integer.parseInt(request.getParameter("id"));

        try {
            // Fetch request with all related data
            Request expertiseRequest = requestService.getRequestById(requestId);

            if (expertiseRequest == null) {
                response.sendRedirect(request.getContextPath() + "/dashboard?error=Request not found");
                return;
            }

            // Check if request is still pending
            if (!expertiseRequest.getRequestStatus().equals(RequestStatus.PENDING)) {
                response.sendRedirect(request.getContextPath() + "/dashboard?error=This request is already handled");
                return;
            }

            // Set request attributes
            request.setAttribute("expertiseRequest", expertiseRequest);
            request.setAttribute("consultation", expertiseRequest.getConsultation());
            request.setAttribute("patient", expertiseRequest.getConsultation().getMedicaleFile().getPatient());
            request.setAttribute("medicaleFile", expertiseRequest.getConsultation().getMedicaleFile());
            request.setAttribute("generalist", expertiseRequest.getConsultation().getGeneralist());
            request.setAttribute("specialist", expertiseRequest.getSpecialist());

            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/consultation/respondPage.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard?error=Error loading request");
        }
    }

    // POST: Submit the response
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String medicalOpinion = request.getParameter("medicalOpinion");
        String action = request.getParameter("action"); // "accept" or "reject"

        if (medicalOpinion == null || medicalOpinion.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/request/respond?id=" + requestId + "&error=Medical opinion is required");
            return;
        }

        try {
            // Fetch the request
            Request expertiseRequest = requestService.getRequestById(requestId);

            if (expertiseRequest == null) {
                response.sendRedirect(request.getContextPath() + "/dashboard?error=Request not found");
                return;
            }

            if (action.equals("accept"))
                handleAcceptRequest(expertiseRequest, medicalOpinion, request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/request/respond?id=" + requestId + "&error=Error processing request");
        }
    }

    private void handleAcceptRequest(Request expertiseRequest, String medicalOpinion,
                                     HttpServletRequest request, HttpServletResponse response) throws IOException {

        expertiseRequest.setRequestStatus(RequestStatus.COMPLETED);
        expertiseRequest.setConsultationDate(LocalDateTime.now());

        Consultation consultation = expertiseRequest.getConsultation();

        try {
            // Save request
            requestService.updateRequestStatus(expertiseRequest.getId(), RequestStatus.COMPLETED);

            // Save consultation if needed
            consultation.setFeedback(medicalOpinion);
            consultation.setTotalPrice(consultation.getTotalPrice() + 300);
            consultationService.update(consultation);

            response.sendRedirect(request.getContextPath() + "/dashboard?success=Expertise response sent successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/request/respond?id=" + expertiseRequest.getId() + "&error=Error saving response");
        }
    }
}