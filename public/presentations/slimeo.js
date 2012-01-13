var SLIMEO = {
  setup: function( vimeo_clip_id, slideshare_id, timings ) {
    
    this.embed_objects( vimeo_clip_id, slideshare_id );
      
    window.vimeo_player_loaded = function() {
      var movie = document.getElementById('movie');
      movie.api_addEventListener('playProgress', 'gotPlayProgress');
      var slides = document.getElementById('slides');
      slides.next();
      setTimeout(function() {
        slides.previous();
      }, 100);
    };

    // Set up sorted timings
    var timestamps = [],
      timings_reversed = {};
    for ( time in timings ) {
      timestamps.push( time );
      timings_reversed[ timings[time] ] = time;
    }
    timestamps = timestamps.sort(function(a,b) { return a - b; });
    
    // Keep slides in sync with video
    var currentSlide = 1,
    goToSlide = function(slide) {
      if ( slide != currentSlide ) {
        document.getElementById('slides').jumpTo( slide );
        currentSlide = slide;
      }
    },
    slideChecker = function() {
      var slides = document.getElementById('slides');
      if ( slides && slides.hasOwnProperty('getCurrentSlide') ) {
        var slidesAt = slides.getCurrentSlide();
        if ( slidesAt != currentSlide ) {
          var movie = document.getElementById('movie');
          movie.api_seekTo( timings_reversed[ slidesAt ] );
        }
      }
      setTimeout( slideChecker, 700 );
    };
    
    window.gotPlayProgress = function( data ) {
      var slide = 1;
      for ( var i=0; i<timestamps.length; i++ ) {
        var time = timestamps[ i ];
        if ( data.seconds < time ) break;
        slide = timings[ time ];
      }
      goToSlide( slide );
    };
    
  },
  
  embed_objects: function(vimeo_clip_id, slideshare_id) {
    swfobject.embedSWF( "http://vimeo.com/moogaloop.swf", "movie", "651", "366", "8", null, {
        clip_id: vimeo_clip_id,
        server: 'vimeo.com',
        show_title: 1,
        show_byline: 0,
        show_portrait: 0,
        color: '00adef',
        fullscreen: 1,
        autoplay: 1,
        loop: 0,
        api: 1
      }, {
        allowfullscreen: 'true',
        allowscriptaccess: 'always',
      }, {});
      
    swfobject.embedSWF("http://static.slidesharecdn.com/swf/ssplayer2.swf", "slides", "455", "366", "8", null, {
      doc : slideshare_id,
      startSlide : 1, 
      rel : 0
    }, {
      allowfullscreen: 'true',
      allowscriptaccess: 'always',          
    }, {
      id: "slides"
    });    
  }
};