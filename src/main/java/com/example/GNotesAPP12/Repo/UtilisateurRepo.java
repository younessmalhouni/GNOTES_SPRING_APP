package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UtilisateurRepo extends JpaRepository<Utilisateur, String> {

    Utilisateur findUtilisateurByCode(Long code);


}
