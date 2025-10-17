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

public class ConsultationService {
    private ConsultationRepository consultationRepository;
    private SpecialistRepository specialistRepository;
    private RequestRepository requestRepository;

    public ConsultationService(EntityManager em) {
        this.consultationRepository = new ConsultationRepository(em);
        this.specialistRepository = new SpecialistRepository(em);
        this.requestRepository = new RequestRepository(em);
    }

    public void create(Consultation consultation) {
        this.consultationRepository.save(consultation);
    }

    public Consultation getConsultationById(int id) {
        return this.consultationRepository.getConsultationById(id);
    }

    public List<Consultation> getAllConsultations() {
        return this.consultationRepository.findAll();
    }

    public void update(Consultation consultation) {
        this.consultationRepository.update(consultation);
    }

    // Récupérer toutes les consultations d'un généraliste
    public List<Consultation> getConsultationsByDoctor(int generalistId) {
        try {
            return consultationRepository.findByDoctorId(generalistId);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations du médecin: " + e.getMessage(), e);
        }
    }

    // Récupérer les consultations d'un généraliste avec filtrage par statut
    public List<Consultation> getConsultationsByDoctorAndStatus(int generalistId, ConsultationStatus status) {
        try {
            return consultationRepository.findByDoctorIdAndStatus(generalistId, status);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations filtrées: " + e.getMessage(), e);
        }
    }

    public void referToSpecialist(int consultationId, int generalistId, int specialistId, LocalDateTime datetime, String description) {
        try {
            // Create new Request object
            Request referralRequest = new Request();

            // Set auto-generated fields
            referralRequest.setCreatedAt(LocalDateTime.now());
            referralRequest.setRequestStatus(RequestStatus.PENDING);

            // Set the consultation date from the datetime parameter
            referralRequest.setConsultationDate(datetime.toLocalDate().atTime(datetime.toLocalTime()));

            referralRequest.setDescription(description);
            referralRequest.setCost(0.0); // Default cost

            // Set relationships
            Consultation consultation = consultationRepository.getConsultationById(consultationId);
            if (consultation == null) {
                throw new IllegalArgumentException("Consultation not found with id: " + consultationId);
            }
            referralRequest.setConsultation(consultation);

            Specialist specialist = specialistRepository.getSpecialistById(specialistId);
            if (specialist == null) {
                throw new IllegalArgumentException("Specialist not found with id: " + specialistId);
            }
            referralRequest.setSpecialist(specialist);

            // Call repository to save
            requestRepository.save(referralRequest);

            // Optional: Update consultation status
            consultation.setConsultationStatus(ConsultationStatus.WAITING_SPECIALIST);
            consultationRepository.update(consultation);

        } catch (Exception e) {
            throw new RuntimeException("Error referring to specialist: " + e.getMessage(), e);
        }
    }

    public Consultation findPendingConsultationByPatientAndGeneralist(int patientId, int generalistId) {
        return this.consultationRepository.findPendingConsultationByPatientAndGeneralist(patientId, generalistId);
    }
}
