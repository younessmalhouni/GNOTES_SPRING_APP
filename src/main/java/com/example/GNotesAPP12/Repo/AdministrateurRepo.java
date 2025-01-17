package com.example.GNotesAPP12.Repo;


import com.example.GNotesAPP12.Model.Administrateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface AdministrateurRepo extends JpaRepository<Administrateur, String> {

    //NbreTotalEtudiant
    @Query("select count(e) from Etudiant e")
    Integer NbreTotalEtudiant();

    //NbreTotalEnseignant
    @Query("select count(p) from Professeur p")
    Integer NbreTotalProfesseurs();

    //NbreDeFilliere
    @Query("select count(f) from Filliere f")
    Integer NbreDeFilliere();

    //NbreDeModule
    @Query("select count(m) from Module m")
    Integer NbreDeModule();
}
