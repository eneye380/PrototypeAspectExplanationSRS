/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.model.Productaspectsentiment;
import aspect.model.Productboughtafter;
import aspect.model.Productdetail;
import aspect.model.ProductrecommendationPK;
import aspect.model.Queryproductandrecommendation;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Local;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
@Local
public interface RecommendationSBLocal {

    ArrayList<Queryproductandrecommendation> retrieveRecommendation(String name);
    
    ArrayList<ProductrecommendationPK> retrieveRecommendation1(String productid);

    ArrayList<Productdetail> retrieveDetail(String name);

    ArrayList<Productaspectsentiment> retrieveAspectSentimentScores(String name);

    ArrayList<Productboughtafter> retrieveBoughtAfterURL(String name);
    
    JSONObject convertToJSON(List list);
    
    JSONObject toJSONAspectSentiment(String productid);
    
    JSONObject toJSONDetail(String productid);
}
