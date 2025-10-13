package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.models.Ticket;
import com.medicale.consultation.consultationmedicale.models.person.Patient;
import com.medicale.consultation.consultationmedicale.repositories.TicketRepository;
import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class TicketService {
    private final TicketRepository ticketRepository;

    public TicketService(EntityManager em) {
        this.ticketRepository = new TicketRepository(em);
    }

    public List<Ticket> findAll() {
        return ticketRepository.findAll();
    }

    public void create(Ticket ticket) {
        ticketRepository.save(ticket);
    }

    public void createTicketForPatient(Patient patient) {
        Ticket ticket = new Ticket(patient, LocalDateTime.now());
        ticketRepository.save(ticket);
    }

    public List<Ticket> findAllByDateDesc() {
        return ticketRepository.findAllByDateDesc();
    }
}
