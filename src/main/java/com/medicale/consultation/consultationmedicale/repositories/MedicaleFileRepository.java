package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import jakarta.persistence.EntityManager;

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
