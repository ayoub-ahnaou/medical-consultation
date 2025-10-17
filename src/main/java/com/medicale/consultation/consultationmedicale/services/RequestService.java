package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.enums.RequestStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.models.consultation.Request;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.repositories.ConsultationRepository;
import com.medicale.consultation.consultationmedicale.repositories.RequestRepository;
import com.medicale.consultation.consultationmedicale.repositories.SpecialistRepository;
import jakarta.persistence.EntityManager;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

public class RequestService {
    private RequestRepository requestRepository;
    private ConsultationRepository consultationRepository;
    private SpecialistRepository specialistRepository;

    public RequestService(EntityManager em) {
        this.requestRepository = new RequestRepository(em);
        this.consultationRepository = new ConsultationRepository(em);
        this.specialistRepository = new SpecialistRepository(em);
    }

    // Créer une nouvelle demande de référencement
    public void createReferralRequest(int consultationId, int generalistId, int specialistId,
                                      LocalDateTime datetime, String description, double cost) {
        try {
            Request request = new Request();

            // Set basic information
            request.setCreatedAt(LocalDateTime.now());
            request.setConsultationDate(datetime);
            request.setDescription(description);
            request.setCost(cost);
            request.setRequestStatus(RequestStatus.PENDING);

            // Set relationships
            Consultation consultation = consultationRepository.getConsultationById(consultationId);
            if (consultation == null) {
                throw new IllegalArgumentException("Consultation non trouvée avec l'ID: " + consultationId);
            }
            request.setConsultation(consultation);

            Specialist specialist = specialistRepository.getSpecialistById(specialistId);
            if (specialist == null) {
                throw new IllegalArgumentException("Spécialiste non trouvé avec l'ID: " + specialistId);
            }
            request.setSpecialist(specialist);

            // Save the request
            requestRepository.save(request);

            // Update consultation status
            consultation.setConsultationStatus(ConsultationStatus.WAITING);
            consultationRepository.update(consultation);

        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la création de la demande de référencement: " + e.getMessage(), e);
        }
    }

    // Récupérer les demandes d'un généraliste
    public List<Request> getRequestsByGeneralist(int generalistId) {
        try {
            return requestRepository.findByGeneralistId(generalistId);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des demandes du généraliste: " + e.getMessage(), e);
        }
    }

    // Récupérer les demandes par statut pour un généraliste
    public List<Request> getRequestsByGeneralistAndStatus(int generalistId, RequestStatus status) {
        try {
            List<Request> allRequests = requestRepository.findByGeneralistId(generalistId);
            return allRequests.stream()
                    .filter(request -> request.getRequestStatus() == status)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des demandes filtrées: " + e.getMessage(), e);
        }
    }

    // Mettre à jour le statut d'une demande
    public void updateRequestStatus(int requestId, RequestStatus newStatus) {
        try {
            Request request = requestRepository.findById(requestId);
            if (request == null) {
                throw new IllegalArgumentException("Demande non trouvée avec l'ID: " + requestId);
            }

            request.setRequestStatus(newStatus);
            requestRepository.update(request);

        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la mise à jour du statut: " + e.getMessage(), e);
        }
    }

    // Récupérer une demande par ID
    public Request getRequestById(int requestId) {
        try {
            return requestRepository.findById(requestId);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération de la demande: " + e.getMessage(), e);
        }
    }
}
