terraform { 
  cloud { 
    
    organization = "piru" 

    workspaces { 
      name = "piru-terraform" 
    } 
  } 
}