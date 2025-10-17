package com.medicale.consultation.consultationmedicale.services;

import com.medicale.consultation.consultationmedicale.models.Agenda;
import com.medicale.consultation.consultationmedicale.models.person.Specialist;
import com.medicale.consultation.consultationmedicale.repositories.AgendaRepository;
import jakarta.persistence.EntityManager;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;

public class AgendaService {
    private final AgendaRepository agendaRepository;

    public AgendaService(EntityManager em) {
        this.agendaRepository = new AgendaRepository(em);
    }

    /**
     * Crée les créneaux horaires pour un spécialiste pour une semaine donnée.
     */
    public List<Agenda> createWeeklyAgenda(
            Specialist specialist,
            LocalDate referenceDate,
            LocalTime startTime,
            LocalTime endTime,
            int slotDurationMinutes,
            List<DayOfWeek> selectedDays
    ) {
        LocalDate monday = referenceDate.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate sunday = monday.plusDays(6);

        List<Agenda> toPersist = new ArrayList<>();

        for (LocalDate date = monday; !date.isAfter(sunday); date = date.plusDays(1)) {
            if (!selectedDays.contains(date.getDayOfWeek())) continue;

            LocalTime slotStart = startTime;
            while (slotStart.plusMinutes(slotDurationMinutes).compareTo(endTime) <= 0) {
                LocalTime slotEnd = slotStart.plusMinutes(slotDurationMinutes);

                // Vérifier le conflit
                boolean conflict = agendaRepository.existsConflict(
                        specialist.getId(),
                        date,
                        slotStart,
                        slotEnd
                );

                if (!conflict) {
                    Agenda slot = new Agenda();
                    slot.setDate(date);
                    slot.setStartTime(slotStart);
                    slot.setEndTime(slotEnd);
                    slot.setAvailable(true);
                    slot.setSpecialist(specialist);
                    toPersist.add(slot);
                }

                slotStart = slotStart.plusMinutes(slotDurationMinutes);
            }
        }

        // Sauvegarde dans la base
        if (!toPersist.isEmpty()) {
            agendaRepository.saveAll(toPersist);
        }

        return toPersist;
    }

    public void delete(Agenda agenda) {
        this.agendaRepository.delete(agenda);
    }

    public List<Agenda> getAllAgenda() {
        return this.agendaRepository.getAll();
    }

    public Agenda getAgendaById(int id) {
        return this.agendaRepository.getById(id);
    }
}
