package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import com.medicale.consultation.consultationmedicale.repositories.MedicaleActRepository;
import jakarta.persistence.EntityManager;

public class MedicaleActService {
    private MedicaleActRepository medicaleActRepository;

    public MedicaleActService(EntityManager em) {
        this.medicaleActRepository = new MedicaleActRepository(em);
    }

    public void create(MedicaleAct medicaleAct) {
        medicaleActRepository.save(medicaleAct);
    }

    public MedicaleAct findById(int actId) {
        return medicaleActRepository.findById(actId);
    }
}
