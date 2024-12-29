package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "module")
public class Module {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "code_module")
    private Long codeModule;

    @Column(name = "nom_module", nullable = false)
    private String nomModule;

    @OneToMany(mappedBy = "module", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Element> elements = new ArrayList<>();

    @OneToMany(mappedBy = "module", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<NoteModule> noteModules = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "filliere_id", nullable = false)
    private Filliere filliere;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_semestre", nullable = false)
    private Semestre semestre;

    // Helper method to manage bidirectional relationship
    public void addElement(Element element) {
        elements.add(element);
        element.setModule(this);
    }

    // Helper method to remove element
    public void removeElement(Element element) {
        elements.remove(element);
        element.setModule(null);
    }

    // Getters and setters
    public Long getCodeModule() {
        return codeModule;
    }

    public void setCodeModule(Long codeModule) {
        this.codeModule = codeModule;
    }

    public String getNomModule() {
        return nomModule;
    }

    public void setNomModule(String nomModule) {
        this.nomModule = nomModule;
    }

    public List<Element> getElements() {
        return elements;
    }

    public void setElements(List<Element> elements) {
        this.elements = elements;
    }

    public List<NoteModule> getNoteModules() {
        return noteModules;
    }

    public void setNoteModules(List<NoteModule> noteModules) {
        this.noteModules = noteModules;
    }

    public Filliere getFilliere() {
        return filliere;
    }

    public void setFilliere(Filliere filliere) {
        this.filliere = filliere;
    }

    public Semestre getSemestre() {
        return semestre;
    }

    public void setSemestre(Semestre semestre) {
        this.semestre = semestre;
    }
}