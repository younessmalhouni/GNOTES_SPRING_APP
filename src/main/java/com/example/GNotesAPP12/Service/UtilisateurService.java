package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Utilisateur;
import com.example.GNotesAPP12.Repo.UtilisateurRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UtilisateurService {

    @Autowired
    private UtilisateurRepo utilisateurRepo;

    public Utilisateur login(String nomUtilisateur, String motDePasse) {
        return utilisateurRepo.findByNomUtilisateurAndMotDePasse(nomUtilisateur, motDePasse);
    }
    public Utilisateur findByNomUtilisateur(String nomUtilisateur) {
        return utilisateurRepo.findByNomUtilisateur(nomUtilisateur);
    }
}
