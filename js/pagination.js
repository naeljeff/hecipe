const ulList = document.getElementById("pageNavigation");
const items = document.getElementsByClassName("fp-content-item");
var totalFood = document.querySelector('input[name=totalFood]').value;
let numOfPages = Math.ceil(totalFood / 2);

function pagination(numOfPages, showedPages){
    var pageList = '';
    var prevPage = showedPages - 1;
    var nextPage = showedPages + 1;
    var currActive;
    
    if(showedPages > 1) {
        pageList += `<li class="first" onclick="pagination(numOfPages, 1)"><span>First</span></li>`;
        pageList += `<li class="prev" onclick="pagination(numOfPages, ${showedPages - 1})"><span>Prev</span></li>`;
    }
    else if(showedPages == 1){
        pageList += `<li class="first disabled"><span>First</span></li>`;
        pageList += `<li class="prev disabled"><span>Prev</span></li>`;
    }

    if(showedPages > 3 && numOfPages > 5){
        pageList += `<li class="page-number" onclick="pagination(numOfPages, 1)"><span>1</span></li>`;
        pageList += `<li class="page-dots">...</li>`;
    }

    if(showedPages == 1){
        nextPage += 2;
    }
    else if(showedPages == 2){
        nextPage += 1;
    }

    if(showedPages == numOfPages){
        if(numOfPages > 3){
            prevPage -= 2;
        }
        else if(numOfPages == 1){
            prevPage -= 0;
        }
        else{
            prevPage -= 1;
        }
    }
    else if(showedPages == numOfPages - 1){
        if(numOfPages == 2){
            prevPage -= 0;
        } else{
            prevPage -= 1;
        }
    }

    for (var i = 0 ; i < totalFood ; i++){
        items[i].classList.remove("active");
        console.log(items[i]);
    }

    for (var totalPages = prevPage; totalPages <= nextPage ; totalPages++){
        if(totalPages > numOfPages){
            continue;
        }
        if(totalPages == 0){
            totalPages += 1;
        }

        if(showedPages == totalPages){
            currActive = "active";

            // If total food = odd
            console.log(showedPages);
            if(totalFood % 2 == 1 && (showedPages * 2 - 1) == totalFood){
                items[showedPages*2 - 2].classList.add("active");
            }
            else{
                items[showedPages*2 - 1].classList.add("active");
                items[showedPages*2 - 2].classList.add("active");
            }
        }
        else {
            currActive = "";
            
        }
        pageList += `<li class="page-number ${currActive}" onclick="pagination(numOfPages, ${totalPages})"><span>${totalPages}</span></li>`;
    }

    if(showedPages < numOfPages - 2 && numOfPages > 6){
        pageList += `<li class="page-dots">...</li>`;
        pageList += `<li class="page-number" onclick="pagination(numOfPages, ${numOfPages})"><span>${numOfPages}</span></li>`;
    }

    if(showedPages < numOfPages){
        pageList += `<li class="next" onclick="pagination(numOfPages, ${showedPages + 1})"><span>Next</span></li>`;
        pageList += `<li class="last" onclick="pagination(numOfPages, ${numOfPages})"><span>Last</span></li>`;
    }
    else if(showedPages == numOfPages){
        pageList += `<li class="next disabled"><span>Next</span></li>`;
        pageList += `<li class="last disabled"><span>Last</span></li>`;
    }
    
    ulList.innerHTML = pageList;
}
pagination(numOfPages, 1);