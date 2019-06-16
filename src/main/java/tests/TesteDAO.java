/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tests;

import model.bean.Pedagoga;
import model.dao.GenericDAO;

/**
 *
 * @author eddunic
 */
public class TesteDAO {

    public static void main(String args[]) {
//        Pedagoga pedagoga = new Pedagoga(123, "Ilma", "il", "123");
//        
//        PedagogaDAO dao = new PedagogaDAO();
//        
//        dao.inserir(pedagoga);

        Pedagoga p = new Pedagoga();
        GenericDAO<Pedagoga> daoP = new GenericDAO<>();
        p.setSiape(123);
        p.setNome("Ilma");
        p.setUsuario("il");
        p.setSenha("123");
        daoP.saveOrUpdate(p);

    }
}

// help link https://www.profissionaisti.com.br/2016/12/design-pattern-criando-uma-classe-dao-generica/