// Define the URL of the video you want to download
const videoUrl = "https://www.tiktok.com/@charlidamelio/video/7145116147929648427";

function downloadTikTokVideo(videoUrl) {
    // Create a new XMLHttpRequest object
    var xhr = new XMLHttpRequest();
    // Set the URL of the video to be downloaded
    xhr.open('GET', videoUrl, true);
    // Set the responseType to "blob" to receive the video data as a binary blob
    xhr.responseType = 'blob';
    // Set the onload event to handle the response
    xhr.onload = function() {
    // Check the status code of the response
    if (this.status === 200) {
    // Create a new Blob from the response data
    var videoBlob = new Blob([this.response], { type: 'video/mp4' });
    // Create a new URL for the video blob
    var videoUrl = URL.createObjectURL(videoBlob);
    // Create a new anchor element
    var a = document.createElement('a');
    // Set the href of the anchor element to the video URL
    a.href = videoUrl;
    // Set the download attribute of the anchor element to the video URL
    a.setAttribute('download', videoUrl);
    // Append the anchor element to the body
    document.body.appendChild(a);
    // Trigger a click event on the anchor element to start the download
    a.click();
    // Remove the anchor element from the body
    document.body.removeChild(a);
    }
    };
    // Send the request
    xhr.send();
    }
    
    // Example usage:
    downloadTikTokVideo(videoUrl);