contract owned{
  function owned () {owner = msg.sender;}
  address owner;
  modifier onlyOwner {
          if (msg.sender != owner)
              throw;
          _;
      }
}

contract chore is owned{

//variables
  string public task;    
  address public child;
  address public parent;
  bool parentApprove;
  bool childApprove;

//mapping
  mapping (address => uint) balances;

//events
event taskUpdate(string comment);

//init state set who is child and who is parent
  function setup(string _task, address _parent, address _child) onlyOwner{
        task = _task;    
        parent = _parent;
        child = _child;
    }

//is the task complete? The child must flag they are done and the parent must approve
  function approve() public {
    if(msg.sender == child){
        childApprove = true;
        taskUpdate("Task completed!");
    }
    else if(msg.sender == parent){
        parentApprove = true;
        taskUpdate("Great! Now go do another one.");
    }
    if(parentApprove && childApprove) payOut();
  }

//payOut should only be called internally but may need to be called with other conditions in the future
  function payOut() internal {
    if(child.send(this.balance)) balances[child] = 0;
    childApprove = false;
    parentApprove = false;
  }

//be able to cancel the task status
  function abort(){
      taskUpdate("Canceled!");
      if(msg.sender == child) {
        childApprove = false;
        taskUpdate("Just kidding");
        }
      else if (msg.sender == parent){
       parentApprove = false;
       taskUpdate("Get real, this chore is not done");
       }
      if(!parentApprove && !childApprove) refund();
  }

//allow deposit of funding for the task
  function deposit() payable{
      if(msg.sender == parent){
       balances[child] += msg.value;
       taskUpdate("The task has been funded!");
       }
      else throw;
  }

  function kill() onlyOwner{
      selfdestruct(owner);
      //kills contract 
  }

  function refund(){
    if(childApprove == false && parentApprove == false) selfdestruct(parent);
    //send money back to parent if both parties agree contract is void
  }

}
