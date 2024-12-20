package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;

@Entity
public class NoteElement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private double noteElement;

    @ManyToOne
    @JoinColumn(name = "id_element", nullable = false) // Match DB column naming conventions
    private Element element;

    @ManyToOne
    @JoinColumn(name = "code_etudiant", nullable = false) // Match DB column naming conventions
    private Etudiant etudiant;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getNoteElement() {
        return noteElement;
    }

    public void setNoteElement(double noteElement) {
        this.noteElement = noteElement;
    }

    public Element getElement() {
        return element;
    }

    public void setElement(Element element) {
        this.element = element;
    }

    public Etudiant getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(Etudiant etudiant) {
        this.etudiant = etudiant;
    }
}
