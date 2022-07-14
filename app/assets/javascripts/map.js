function initMap(){
    let map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: <%= @photo.latitude %>, lng: <%= @photo.longitude %> },
    zoom: 15
    });
}
