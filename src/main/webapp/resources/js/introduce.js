var cntflag = false;
window.onscroll = function(){
            let scrollTop = document.documentElement.scrollTop;
            let clientHeight = document.documentElement.clientHeight;
            let scrollHeight = document.documentElement.scrollHeight;
            console.log("scrollTop:", document.documentElement.scrollTop)
            console.log("clientHeight:", document.documentElement.clientHeight)
            console.log("scrollHeight:", document.documentElement.scrollHeight)
            console.log("==================================================")

            const cont450 = document.querySelectorAll(".cont450");
            const cont1200 = document.querySelector(".cont1200").children;
            const cont2100 = document.querySelector(".cont2100").children;
            const nums = document.querySelectorAll(".num");
            const cont2800 = document.querySelectorAll(".cont2800");
            if(scrollTop>=450){
                for(let i=0; i<cont450.length; i++){
                    
                    if(i==1){
                        setTimeout(() => {
                            cont450[i].style.opacity=1;
                            cont450[i].style.bottom=0;
                        }, 200);
                    }else{
                        cont450[i].style.opacity=1;
                        cont450[i].style.bottom=0;
                    }
                }
            }else{
                for(let i=0; i<cont450.length; i++){
                    cont450[i].style.opacity=0;
                    cont450[i].style.bottom="-30px";
                }
            }
            
            if(scrollTop>=1200){
                for(let i=0; i<cont1200.length; i++){
                    
                    if(i==1){
                        setTimeout(() => {
                            cont1200[i].style.opacity=1;
                            cont1200[i].style.top=0;
                        }, 300);
                    }else{
                        cont1200[i].style.opacity=1;
                        cont1200[i].style.top=0;
                    }
                }
            }else{
                for(let i=0; i<cont1200.length; i++){
                    cont1200[i].style.opacity=0;
                    cont1200[i].style.top="30px";
                }
            }

            if(scrollTop>=2100){
                for(let i=0; i<cont2100.length; i++){
                    
                    if(i==0){
                        setTimeout(() => {
                            cont2100[i].style.opacity=1;
                            cont2100[i].style.top=690;
                        }, 200);
                    }else{
                        cont2100[i].style.opacity=1;
                        cont2100[i].style.top=800;
                    }
                }
            }else{
                for(let i=0; i<cont2100.length; i++){
                    if(i==0){
                        setTimeout(() => {
                            cont2100[i].style.opacity=0;
                            cont2100[i].style.top=770;
                        }, 200);
                    }else{
                        cont2100[i].style.opacity=0;
                        cont2100[i].style.top=660;
                    }
                }
            }

            if(scrollTop>=2800){

                if(!cntflag){
                    countUp(300,2000,nums[0],1)
                    countUp(500,2000,nums[1],1)
                    countUp(1200,2000,nums[2],2.2)
                    countUp(20,2000,nums[3],1)
                    cntflag=true;
                }
                for(let i=0; i<cont2800.length; i++){
                    cont2800[i].style.opacity=1;
                    cont2800[i].style.top="1850px";
                }

            }else{
                for(let i=0; i<cont2800.length; i++){
                    cont2800[i].style.opacity=0;
                    cont2800[i].style.top="1750px";
                }
            }
        }
        
    function countUp(targetCount, duration, el,ad) {
        let count = 0;
        const interval = duration*ad / targetCount;

        const timer = setInterval(() => {
            el.innerText = Math.ceil(count);
            count+=ad;

            if (count > targetCount) {
                clearInterval(timer);
            }
        }, interval);
    }