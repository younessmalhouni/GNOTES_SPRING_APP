package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Utilisateur;
import com.example.GNotesAPP12.Repo.UtilisateurRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UtilisateurService {

    @Autowired
    private UtilisateurRepo utilisateurRepo;

    public Utilisateur getUtilisateurByCode(Long code) {
        return utilisateurRepo.findUtilisateurByCode(code);
    }

}
