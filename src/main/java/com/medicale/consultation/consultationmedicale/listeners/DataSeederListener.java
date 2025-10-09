package com.medicale.consultation.consultationmedicale.listeners;

import com.medicale.consultation.consultationmedicale.config.JPAUtils;
import com.medicale.consultation.consultationmedicale.utils.Seeder;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DataSeederListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        EntityManager em = JPAUtils.getEntityManager();

        try {
            Seeder.seed(em);
        } catch (Exception e) {
            e.printStackTrace();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            em.close();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // something to run when application stops
    }
}
