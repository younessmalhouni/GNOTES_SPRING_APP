package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Element {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_element")
    private Long idElement;

    @Column(nullable = false)
    private String nomElement;

    @Column(nullable = false)
    private double coefficient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "module_id", referencedColumnName = "code_module")
    private Module module;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "code_prof", referencedColumnName = "code")
    private Professeur professeur;

    @OneToMany(mappedBy = "element", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Modalite_Evaluation> modalites = new ArrayList<>();

    @OneToMany(mappedBy = "element", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<NoteElement> noteElements = new ArrayList<>();

    // Helper method to manage bidirectional relationship
    public void addModalite(Modalite_Evaluation modalite) {
        modalites.add(modalite);
        modalite.setElement(this);
    }

    // Helper method to remove modalite
    public void removeModalite(Modalite_Evaluation modalite) {
        modalites.remove(modalite);
        modalite.setElement(null);
    }

    // Getters and setters
    public Long getIdElement() {
        return idElement;
    }

    public void setIdElement(Long idElement) {
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
