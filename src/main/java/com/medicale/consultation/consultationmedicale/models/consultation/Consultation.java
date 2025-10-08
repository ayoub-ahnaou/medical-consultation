package com.medicale.consultation.consultationmedicale.models.consultation;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "consultations")
public class Consultation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, name = "created_at")
    private LocalDate createdAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, name = "consultation_status")
    private ConsultationStatus consultationStatus;

    @ManyToOne
    @JoinColumn(name = "medical_file_id", nullable = false)
    private MedicaleFile medicalFile;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL)
    private List<MedicaleAct> medicaleActs = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "generalist_id")
    private Generalist generalist;

    public Consultation(int id, LocalDate createdAt, ConsultationStatus consultationStatus) {
        this.id = id;
        this.createdAt = createdAt;
        this.consultationStatus = consultationStatus;
    }

    public Consultation() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public ConsultationStatus getConsultationStatus() {
        return consultationStatus;
    }

    public void setConsultationStatus(ConsultationStatus consultationStatus) {
        this.consultationStatus = consultationStatus;
    }
}
