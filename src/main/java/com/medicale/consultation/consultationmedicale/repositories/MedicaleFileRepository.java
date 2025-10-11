package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class MedicaleFileRepository {
    private final EntityManager em;

    public MedicaleFileRepository(EntityManager em) {
        this.em = em;
    }

    public void save(MedicaleFile file) {
        em.getTransaction().begin();
        em.persist(file);
        em.getTransaction().commit();
    }

    public void update(MedicaleFile file) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(file); // merge updates an existing entity
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }

    public MedicaleFile findByPatientId(int patientId) {
        try {
            return em.createQuery(
                            "SELECT m FROM MedicaleFile m WHERE m.patient.id = :pid", MedicaleFile.class)
                    .setParameter("pid", patientId)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
