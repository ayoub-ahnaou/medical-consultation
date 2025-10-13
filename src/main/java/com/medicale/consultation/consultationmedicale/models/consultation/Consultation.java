package com.medicale.consultation.consultationmedicale.models.consultation;

import com.medicale.consultation.consultationmedicale.enums.ConsultationStatus;
import com.medicale.consultation.consultationmedicale.models.MedicaleFile;
import com.medicale.consultation.consultationmedicale.models.person.Generalist;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "consultations")
public class Consultation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, name = "created_at")
    private LocalDateTime createdAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, name = "consultation_status", length = 20)
    private ConsultationStatus consultationStatus;

    @Column(name = "feedback", nullable = false)
    private String feedback;

    @Column(name = "total_price")
    private double totalPrice = 0.0;

    @ManyToOne
    @JoinColumn(name = "medical_file_id", nullable = false)
    private MedicaleFile medicaleFile;

    @ManyToMany
    @JoinTable(
            name = "consultation_medicale_act",
            joinColumns = @JoinColumn(name = "consultation_id"),
            inverseJoinColumns = @JoinColumn(name = "medicale_act_id")
    )
    private List<MedicaleAct> medicaleActs = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "generalist_id")
    private Generalist generalist;

    public Consultation(ConsultationStatus consultationStatus, String feedback, double totalPrice, MedicaleFile medicaleFile, List<MedicaleAct> medicaleActs, Generalist generalist) {
        this.createdAt = LocalDateTime.now();
        this.consultationStatus = consultationStatus;
        this.feedback = feedback;
        this.totalPrice = totalPrice;
        this.medicaleFile = medicaleFile;
        this.medicaleActs = medicaleActs;
        this.generalist = generalist;
    }

    public Consultation() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public ConsultationStatus getConsultationStatus() {
        return consultationStatus;
    }

    public void setConsultationStatus(ConsultationStatus consultationStatus) {
        this.consultationStatus = consultationStatus;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public MedicaleFile getMedicaleFile() {
        return medicaleFile;
    }

    public void setMedicaleFile(MedicaleFile medicaleFile) {
        this.medicaleFile = medicaleFile;
    }

    public List<MedicaleAct> getMedicaleActs() {
        return medicaleActs;
    }

    public void setMedicaleActs(List<MedicaleAct> medicaleActs) {
        this.medicaleActs = medicaleActs;
    }

    public void addMedicaleAct(MedicaleAct act) {
        this.medicaleActs.add(act);
    }

    public Generalist getGeneralist() {
        return generalist;
    }

    public void setGeneralist(Generalist generalist) {
        this.generalist = generalist;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
