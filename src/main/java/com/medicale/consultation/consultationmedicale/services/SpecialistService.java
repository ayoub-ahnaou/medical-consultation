package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.repositories.SpecialistRepository;
import jakarta.persistence.EntityManager;

import java.util.List;

public class SpecialistService {
    private final SpecialistRepository specialistRepository;

    public SpecialistService(EntityManager em) {
        this.specialistRepository = new SpecialistRepository(em);
    }

    public List<Specialist> getAllSpecialists() {
        return this.specialistRepository.findAll();
    }

    public Specialist getSpecialistById(int specialistId) {
        return this.specialistRepository.getSpecialistById(specialistId);
    }
}
