/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.controller_bean;

import javax.ejb.Local;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
@Local
public interface AspectScoreJSONSBLocal {
    JSONObject fetchAspectJSON(); 
}
