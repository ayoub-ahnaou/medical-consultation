package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class GeneralistRepository {
    private EntityManager em;

    public GeneralistRepository(EntityManager em) {
        this.em = em;
    }

    public Generalist findByUsernameAndPassword(String username) {
        try {
            TypedQuery<Generalist> query = em.createQuery(
                    "SELECT g FROM Generalist g WHERE g.username = :username",
                    Generalist.class
            );
            query.setParameter("username", username);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
