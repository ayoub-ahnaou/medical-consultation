package com.medicale.consultation.consultationmedicale.repositories;

import com.medicale.consultation.consultationmedicale.models.person.Nurse;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class GeneralistRepository {
    private EntityManager em;

    public GeneralistRepository(EntityManager em) {
        this.em = em;
    }

    public Nurse findByUsernameAndPassword(String username, String password) {
        try {
            TypedQuery<Nurse> query = em.createQuery(
                    "SELECT g FROM Generalist g WHERE g.username = :username AND g.password = :password",
                    Nurse.class
            );
            query.setParameter("username", username);
            query.setParameter("password", password);

            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
