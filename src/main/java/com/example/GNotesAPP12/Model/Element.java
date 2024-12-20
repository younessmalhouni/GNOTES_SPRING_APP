package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;
import java.util.List;

@Entity
public class Element {

    @Id
    @Column(name = "id_element") // Match DB column naming conventions
    private String idElement;

    private String nomElement;
    private double coefficient;

    @ManyToOne
    @JoinColumn(name = "module_id")
    private Module module;

    @ManyToOne
    @JoinColumn(name = "professeur_id")
    private Professeur professeur;

    @OneToMany(mappedBy = "element", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Modalite_Evaluation> modalites;

    @OneToMany(mappedBy = "element", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<NoteElement> noteElements;

    // Getters and Setters
    public String getIdElement() {
        return idElement;
    }

    public void setIdElement(String idElement) {
        this.idElement = idElement;
    }

    public String getNomElement() {
        return nomElement;
    }

    public void setNomElement(String nomElement) {
        this.nomElement = nomElement;
    }

    public double getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(double coefficient) {
        this.coefficient = coefficient;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Professeur getProfesseur() {
        return professeur;
    }

    public void setProfesseur(Professeur professeur) {
        this.professeur = professeur;
    }

    public List<Modalite_Evaluation> getModalites() {
        return modalites;
    }

    public void setModalites(List<Modalite_Evaluation> modalites) {
        this.modalites = modalites;
    }

    public List<NoteElement> getNoteElements() {
        return noteElements;
    }

    public void setNoteElements(List<NoteElement> noteElements) {
        this.noteElements = noteElements;
    }
}
