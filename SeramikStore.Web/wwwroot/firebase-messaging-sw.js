importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyCQkw2a1l3JFnwGrvtlhHqDimRR8BYCaSs",
  projectId: "dibuceramic-notifications",
  messagingSenderId: "151007975605",
  appId: "1:151007975605:web:eb9121c3783caaad8646fc"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  self.registration.showNotification(payload.notification.title, {
    body: payload.notification.body,
    icon: '/images/logo/logowebp.webp'
  });
});