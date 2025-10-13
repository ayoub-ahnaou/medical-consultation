package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.repositories.MedicaleFileRepository;
import jakarta.persistence.EntityManager;

public class MedicaleFileService {
    private final MedicaleFileRepository repository;

    public MedicaleFileService(EntityManager em) {
        this.repository = new MedicaleFileRepository(em);
    }

    public void create(MedicaleFile file) {
        repository.save(file);
    }

    public void update(MedicaleFile file) {
        repository.update(file);
    }

    public MedicaleFile findByPatientId(int patientId) {
        return repository.findByPatientId(patientId);
    }
}
