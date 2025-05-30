<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<section class="content-header">
    <div class="container-fluid">

        <!-- line1 -->
        <div class="row">
            <div class="col-md-4">
                <div class="card card-outline card-primary">
                    <div class="card-header">
                        <h3 class="card-title">나의 근태현황</h3>
                    </div>
                
                    <div class="card-body">
                        <div style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block;" width="394" height="250">

                            <div class="row">
                                <div class="col-md-6 text-center">근무형태 | </div>
                                <div class="col-md-6 text-center" id="groupNm">근로제그룹명</div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 text-center">근무시간 | </div>
                                <div class="col-md-6 text-center" id="groupWork">09:00:00 ~ 18:00:00</div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 text-center">휴게시간 | </div>
                                <div class="col-md-6 text-center" id="groupRest">12:00:00 ~ 13:00:00</div>
                            </div>

                            <hr>

                            <div class="row">
                                <div class="col-md-6 text-center">출근시간</div>
                                <div class="col-md-6 text-center">퇴근시간</div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 text-center" id="workBgngDt">09:00:00</div>
                                <div class="col-md-6 text-center" id="workEndDt">18:00:00</div>
                            </div>

                        </div>
                    </div>
                
                </div>
            </div>

            <div class="col-md-4">
                <!-- <div class="mb-3"> -->
                    <div class="card card-outline card-primary">
                        <div class="card-header">
                            금일 근무시간
                        </div>
                        
                        <div class="card-body">
                            <canvas id="dayWork" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block;" width="394" height="250" class="chartjs-render-monitor"></canvas>
                            <!-- <canvas id="workTodayChart"></canvas> -->
                        </div>
                    </div>
                    <!-- </div> -->
                </div>
                
                <div class="col-md-4">
                <!-- <div class="mb-3"> -->
                    <div class="card card-outline card-primary">
                        <div class="card-header">
                            금주 근무시간
                        </div>
    
                        <div class="card-body">
                            <canvas id="weekWork" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block;" width="394" height="250" class="chartjs-render-monitor"></canvas>
                        </div>
                    </div>
                <!-- </div> -->


            </div>


        </div>

        <!-- line2 -->
        <div class="row">
            <div class="col">
                <div class="card card-outline card-primary">
                    <div class="card-header">
                        <h3 class="card-title">월간 근태현황</h3>
                    </div>
                
                    <div class="card-body">
                        <canvas id="workMonthChart"></canvas>
                    </div>
                
                </div>
            </div>

        </div>

    </div>
</section>

<script>
//전역변수
const times =[];
for(let i=9; i<=24; i++){
    if(i<10) i= "0"+i;
    times.push(i+"시");
}
console.log("times:",times);

//전역함수

//이벤트

$(function(){
    workGroup();
    workToday();
    // drawWorkMonthChart();
    drawDayChart();
    drawWeekChart();
});


// 금주 근무시간
function drawWeekChart(){
    var donutChartCanvas = $('#weekWork').get(0).getContext('2d')
    var donutData = {
        labels: [
            '정규시간',
            '연장시간',
            '남은근무시간'
        ],
        datasets: [
            {
                data: [35, 8, 5],
                backgroundColor: ['rgb(54, 162, 235)', 'rgb(255, 99, 132)', 'gray'],
            }
        ]
    }
    var donutOptions = {
        maintainAspectRatio: false,
        responsive: true,
    }
    new Chart(donutChartCanvas, {
        type: 'doughnut',
        data: donutData,
        options: donutOptions
    })
}

// 금일 근무시간
function drawDayChart() {

    var donutChartCanvas = $('#dayWork').get(0).getContext('2d')
    var donutData = {
        labels: [
            '정규시간',
            '연장시간',
            '남은근무시간'
        ],
        datasets: [
            {
                data: [8, 3, 0.5],
                backgroundColor: ['rgb(54, 162, 235)', 'rgb(255, 99, 132)', 'gray'],
            }
        ]
    }
    var donutOptions = {
        maintainAspectRatio: false,
        responsive: true,
    }
    new Chart(donutChartCanvas, {
        type: 'doughnut',
        data: donutData,
        options: donutOptions
    })

}




// 월간 근무시간 차트
function drawWorkMonthChart() {
    var ctx = document.getElementById("workMonthChart").getContext("2d");
    
    const labels = Utils.months({ count: 7 });
    const data = {
        labels: labels,
        datasets: [{
            label: 'My First Dataset',
            data: [65, 59, 80, 81, 56, 55, 40],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(255, 205, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(201, 203, 207, 0.2)'
            ],
            borderColor: [
                'rgb(255, 99, 132)',
                'rgb(255, 159, 64)',
                'rgb(255, 205, 86)',
                'rgb(75, 192, 192)',
                'rgb(54, 162, 235)',
                'rgb(153, 102, 255)',
                'rgb(201, 203, 207)'
            ],
            borderWidth: 1
        }]
    }

    const config = {
        type: 'bar',
        data: data,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        },
    };

};


// 오늘의 근로
function workToday(){{
    $.ajax({
        url: `/everyware/workStats/getWorkToday`,
        type: "GET",
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            console.log("workToday : ", res);
            var workBgngDt = res.workBgngDt;
            var workEndDt = res.workEndDt;

            // var timeDiff = calculateTimeDifference(workBgngDt, workEndDt);
            // console.log(timeDiff)

            $("#workBgngDt").val(workBgngDt);
            $("#workEndDt").val(workEndDt);

            // 금일 근무시간
            // drawWorkTodayChart(timeDiff);

        },
        error: function (xhr) {
            alert("Error: " + xhr.status);
        }
    });
}}


// 근로제 그룹
function workGroup() {
    $.ajax({
        url: `/everyware/workStats/getWorkGroup`,
		type: "GET",
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(headerName, token);
		},
		success: function (res) {
			console.log("workGroup : ", res);
            var groupNm = res.groupNm;
            var groupWorkBgngDt = res.groupWorkBgngDt;
            var groupWorkEndDt = res.groupWorkEndDt;
            var groupRestBgngDt = res.groupRestBgngDt;
            var groupRestEndDt = res.groupRestEndDt;

            var groupWork = `\${groupWorkBgngDt} ~ \${groupWorkEndDt}`;
            var groupRest = `\${groupRestBgngDt} ~ \${groupRestEndDt}`;

            // console.log("groupNm", groupNm);
            // console.log("groupWork", groupWork);
            // console.log("groupRest", groupRest);

            $("#groupNm").val(groupNm);
            $("#groupWork").val(groupWork);
            $("#groupRest").val(groupRest);
        },
        error: function (xhr) {
			alert("Error: " + xhr.status);
		}
    });
}


//
function parseTime(timeString) {
    console.log(timeString)
    const [hours, minutes, seconds] = timeString.split(":");
    return {
        hours: parseInt(hours), 
        minutes: parseInt(minutes),
        seconds: parseInt(seconds),
    };
}

//
function formatTime(time) {
    return time.toString().padStart(2, "0");
}

// 근무시간 계산
function calculateTimeDifference(startTime, endTime) {
    const start = parseTime(startTime);
    const end = parseTime(endTime);
    console.log(start)
    console.log(end)

    let hoursDiff = end.hours - start.hours;
    let minutesDiff = end.minutes - start.minutes;
    let secondsDiff = end.seconds - start.seconds;

    if (secondsDiff < 0) {
        secondsDiff += 60;
        minutesDiff--;
    }

    if (minutesDiff < 0) {
        minutesDiff += 60;
        hoursDiff--;
    }
    return formatTime(hoursDiff) + ":" + formatTime(minutesDiff) + ":" + formatTime(secondsDiff);
}
</script>