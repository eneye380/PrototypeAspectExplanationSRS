/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.controller_bean;

import aspect.model.Queryproductandrecommendation;
import java.util.ArrayList;
import javax.ejb.Local;

/**
 *
 * @author eneye380
 */
@Local
public interface ProductSBLocal {

    ArrayList<Queryproductandrecommendation> findProduct(String name);
    
}
