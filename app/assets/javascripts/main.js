$(function(){
    function get_new_topic(){
        if($("#topic_load").attr("checked") == "checked"){
            var f_li = $("#blogInfo li:first");
            var topic_id = 0;
            if(f_li){
                topic_id = f_li.attr("topic_id") * 1;
            }
            $.getJSON("/topics/get_new_topic?topic_id=" + topic_id,function(result){
                $.each(result, function(i, data){
                    if(data.id > topic_id)
                        {
                            $("<li role='topic_"+ data.id +"' topic_id='"+ data.id+"'>"+data.title+"</li>").prependTo("#blogInfo");
                        }
                    });
                })
            }
        };
        $("#getNewInfo").click(function(){
            var f_li = $("#blogInfo li:first");
            var topic_id = 0;
            if(f_li){
                topic_id = f_li.attr("topic_id") * 1;
            }
            $.getJSON("/topics/get_new_topic?topic_id=" + topic_id,function(result){
                $.each(result, function(i, data){
                    if(data.id > topic_id)
                        {
                            $("<li role='topic_"+ data.id +"' topic_id='"+ data.id+"'>"+data.title+"</li>").prependTo("#blogInfo");
                        }
                    });
                })
            })
            $("#getLastInfo").click(function(){
                var f_li = $("#blogInfo li:last");
                var topic_id = 0;
                if(f_li){
                    topic_id = f_li.attr("topic_id") * 1;
                }
                $.getJSON("/topics/get_last_topic?topic_id="+topic_id,function(result){
                    $.each(result, function(i, data){
                        if(data.id < topic_id)
                            {
                                $("<li role='topic_"+ data.id +"' topic_id='"+ data.id+"'>"+data.title+"</li>").prependTo("#blogInfo");
                            }
                        });
                    })
                })
                function load_topic()
                {
                    setInterval(get_new_topic,30000);
                }
                load_topic();
            })
            