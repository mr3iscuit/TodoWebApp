function checkbox(){
    let checkbox = document.getElementById("check");
    let isDone = document.getElementById("isDone");
    console.log("isDone Value: " + isDone.value)

    console.log("Checkbox Checked: " + checkbox.checked);


    if (checkbox.checked == true){
        checkbox.checked = true;
        isDone.value = "true";
        console.log("Checkbox Checked cond: " + checkbox.checked);
        console.log("isDone Value cond: " + isDone.value)
    }else{
        checkbox.checked = false;
        isDone = "false";
        console.log("Checkbox Checked cond: " + checkbox.checked);
        console.log("isDone Value cond: " + isDone.value)
    }
}