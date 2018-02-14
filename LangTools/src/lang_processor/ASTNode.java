/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lang_processor;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @authors Meruyert Jakipbekova and Alibek Zhakubayev
 */
public class ASTNode {
    
    private String nontermName; 
    private String kind;
    private String termvalue = null;
    private List<ASTNode> children;

    public ASTNode (String kind){
        this.kind = kind;
        this.nontermName = null;
        this.children = new ArrayList<>();
    }
    
    public ASTNode(String kind, String name, String value){
        this.kind = kind;
        nontermName = name;
        termvalue = value;
        this.children = new ArrayList<>();
    }
    
    public void addChild(ASTNode child){
        this.children.add(child);
    }
    
    @Override
    public String toString(){
        String result = "";
        
        if (nontermName != null){
            result += "\n Kind of node: " + kind + " with name "
                    + nontermName + " and value " + termvalue + " with children {";
        }else{
            result += "\n Kind of node: " + kind + " with children {";
        }
        
        for(int i = 0; i < children.size(); i++){
            result += children.get(i).toString();
        }
        result += "}";
        return result;
        
    }
}
