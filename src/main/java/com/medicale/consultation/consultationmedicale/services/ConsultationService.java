package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.consultation.Consultation;
import com.medicale.consultation.consultationmedicale.repositories.ConsultationRepository;
import jakarta.persistence.EntityManager;

import java.util.Collections;
import java.util.List;

public class ConsultationService {
    private ConsultationRepository consultationRepository;

    public ConsultationService(EntityManager em) {
        this.consultationRepository = new ConsultationRepository(em);
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
}
