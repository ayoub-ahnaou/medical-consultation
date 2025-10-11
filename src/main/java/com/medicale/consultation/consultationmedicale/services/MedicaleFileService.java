package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.repositories.MedicaleFileRepository;

public class MedicaleFileService {
    private final MedicaleFileRepository repository;

    public MedicaleFileService(MedicaleFileRepository repository) {
        this.repository = repository;
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
