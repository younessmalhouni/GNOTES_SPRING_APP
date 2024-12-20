package com.example.GNotesAPP12.Model;
import com.example.GNotesAPP12.Model.Etudiant;

import jakarta.persistence.*;

@Entity
public class NoteModalite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "etudiant_id", nullable = false)
    private Etudiant etudiant;

    @ManyToOne
    @JoinColumn(name = "modalite_id", nullable = false)
    private Modalite_Evaluation modaliteEvaluation;

    private Double noteModalite;

    // Constructors
    public NoteModalite() {}

    public NoteModalite(Etudiant etudiant, Modalite_Evaluation modaliteEvaluation, Double noteModalite) {
        this.etudiant = etudiant;
        this.modaliteEvaluation = modaliteEvaluation;
        this.noteModalite = noteModalite;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Etudiant getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(Etudiant etudiant) {
        this.etudiant = etudiant;
    }

    public Modalite_Evaluation getModaliteEvaluation() {
        return modaliteEvaluation;
    }

    public void setModaliteEvaluation(Modalite_Evaluation modaliteEvaluation) {
        this.modaliteEvaluation = modaliteEvaluation;
    }

    public Double getNoteModalite() {
        return noteModalite;
    }

    public void setNoteModalite(Double noteModalite) {
        this.noteModalite = noteModalite;
    }
}
