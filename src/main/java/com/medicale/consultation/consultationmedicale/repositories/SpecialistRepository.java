package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class SpecialistRepository {
    private EntityManager em;

    public SpecialistRepository(EntityManager em) {
        this.em = em;
    }

    public Specialist findByUsernameAndPassword(String username) {
        try {
            TypedQuery<Specialist> query = em.createQuery(
                    "SELECT s FROM Specialist s WHERE s.username = :username",
                    Specialist.class
            );
            query.setParameter("username", username);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Specialist> findAll() {
        return em.createQuery("SELECT s FROM Specialist s", Specialist.class).getResultList();
    }
}
