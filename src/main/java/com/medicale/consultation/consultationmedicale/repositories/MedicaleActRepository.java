package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.consultation.MedicaleAct;
import jakarta.persistence.EntityManager;

import java.util.List;

public class MedicaleActRepository {
    private EntityManager em;

    public MedicaleActRepository(EntityManager em) {
        this.em = em;
    }

    public void save(MedicaleAct act) {
        em.getTransaction().begin();
        em.persist(act);
        em.getTransaction().commit();
    }

    public MedicaleAct findById(int actId) {
        return em.find(MedicaleAct.class, actId);
    }

    public List<MedicaleAct> findAll() {
        return em.createQuery("SELECT m FROM MedicaleAct m", MedicaleAct.class).getResultList();
    }
}
