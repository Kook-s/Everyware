$(function(){
    var scrollNum=0;
    $(window).scroll(function(){

        console.log($(window).scrollTop());
        scrollNum=$(window).scrollTop()
        console.log(scrollNum)
        // $(window).scrollTop(800)
        if(scrollNum >= 965){
        }else{
          $(".contentMainCover, .contentMain").css("display", "block")
          $(".scroll_evnet").css("display","block");
        }
        
        if(scrollNum>=750){
        $(".scroll_evnet").css("display","none");
        }
        if(scrollNum>=800){
          $(".content_row").css("position","fixed");
          $(".content_row").css("display","block");
          $(".content_row").css("padding-right",scrollNum);
          $(".content_row").addClass("active");
          
          $(".img_cover1").addClass("active");
        }else{
          $(".img_cover1").removeClass("active");
        }
        if(scrollNum<=800){
          $(".contentMain").addClass("active");
        }else{
          $(".contentMain").removeClass("active");
        }

        if(scrollNum>=1350){
          $(".img_cover2").addClass("active");
        }else{
          $(".img_cover2").removeClass("active");
        }
        if(scrollNum>=2000){
          $(".content_img2").addClass("active");
          $(".ani_img2").addClass("active");
        }else{
          $(".content_img2").removeClass("active");
          $(".ani_img2").removeClass("active");
        }
        if(scrollNum>=3011){
          $(".img_cover3").addClass("active");
        }else{
          $(".img_cover3").removeClass("active");
        }
        if(scrollNum>=4650){
          $(".img_cover4").addClass("active");
        }else{
          $(".img_cover4").removeClass("active");
        }

        if(scrollNum <=400){
        $(".content_row").css("display","none");

        }

    });
    $(".open_menu").on("click",function(){
        $(".total_menu").css("position","fixed");
        if($(".total_menu").css("display")=="none"){
          $(".total_menu").css("display","flex");
        }else{
          $(".total_menu").css("display","none");
        }
      })

      $('#menu1,#menu2,#menu3,#menu4').on('mouseenter', function() {
        $(this).find('.menu_2').addClass('active');
      }).on('mouseleave', function() {
        $(this).find('.menu_2').removeClass('active');

      });

      

      })