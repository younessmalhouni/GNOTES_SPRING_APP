package com.example.GNotesAPP12.Model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "etudiant")
public class Etudiant {

    @Id
    @Column(name = "code_etudiant")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long codeEtudiant;

    @Column(name = "nom_etudiant", nullable = false)
    private String nomEtudiant;

    @Column(name = "prenom_etudiant", nullable = false)
    private String prenomEtudiant;

    private String email;
    @Lob
    @Column(name = "image", columnDefinition = "LONGTEXT")
    private String image;


    @ManyToOne
    @JoinColumn(name = "filliere_id", nullable = false)
    private Filliere filliere;

    @OneToMany(mappedBy = "etudiant", cascade = CascadeType.ALL)
    private List<NoteModalite> noteModalites;

    @OneToMany(mappedBy = "etudiant", cascade = CascadeType.ALL)
    private List<NoteElement> noteElements;

    @OneToMany(mappedBy = "etudiant", cascade = CascadeType.ALL)
    private List<NoteModule> noteModules;

    @ManyToOne
    @JoinColumn(name = "id_semestre", nullable = false)
    private Semestre semestre;

    // Default constructor
    public Etudiant() {}

    // Getters and Setters
    public Long getCodeEtudiant() {
        return codeEtudiant;
    }

    public void setCodeEtudiant(Long codeEtudiant) {
        this.codeEtudiant = codeEtudiant;
    }

    public String getNomEtudiant() {
        return nomEtudiant;
    }

    public void setNomEtudiant(String nomEtudiant) {
        this.nomEtudiant = nomEtudiant;
    }

    public String getPrenomEtudiant() {
        return prenomEtudiant;
    }

    public void setPrenomEtudiant(String prenomEtudiant) {
        this.prenomEtudiant = prenomEtudiant;
    }

    public Semestre getSemestre() {
        return semestre;
    }

    public void setSemestre(Semestre semestre) {
        this.semestre = semestre;
    }

    public Filliere getFilliere() {
        return filliere;
    }

    public void setFilliere(Filliere filliere) {
        this.filliere = filliere;
    }

    public List<NoteModalite> getNoteModalites() {
        return noteModalites;
    }

    public void setNoteModalites(List<NoteModalite> noteModalites) {
        this.noteModalites = noteModalites;
    }

    public List<NoteElement> getNoteElements() {
        return noteElements;
    }

    public void setNoteElements(List<NoteElement> noteElements) {
        this.noteElements = noteElements;
    }

    public List<NoteModule> getNoteModules() {
        return noteModules;
    }

    public void setNoteModules(List<NoteModule> noteModules) {
        this.noteModules = noteModules;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
