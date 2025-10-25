<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chatbot TVT Future</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f7f7f7; }
        #chat-container { width: 400px; margin: 40px auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; }
        #chat-messages { height: 400px; overflow-y: auto; padding: 16px; border-bottom: 1px solid #eee; }
        .msg { margin-bottom: 12px; }
        .msg.user { text-align: right; }
        .msg.bot { text-align: left; color: #222; }
        .msg .bubble { display: inline-block; padding: 8px 14px; border-radius: 16px; max-width: 80%; }
        .msg.user .bubble { background: #007bff; color: #fff; }
        .msg.bot .bubble { background: #f1f1f1; color: #222; }
        #chat-form { display: flex; padding: 12px; }
        #chat-input { flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 16px; }
        #chat-send { margin-left: 8px; padding: 8px 18px; border: none; background: #007bff; color: #fff; border-radius: 16px; cursor: pointer; }
    </style>
</head>
<body>
<div id="chat-container">
    <div id="chat-messages"></div>
    <form id="chat-form" onsubmit="return sendMessage();">
        <input id="chat-input" type="text" placeholder="Nhập câu hỏi" autocomplete="off" required />
        <button id="chat-send" type="submit">Gửi</button>
    </form>
</div>
<script>
    const chatMessages = document.getElementById('chat-messages');
    const chatInput = document.getElementById('chat-input');

    function appendMessage(text, sender) {
        const msg = document.createElement('div');
        msg.className = 'msg ' + sender;
        const bubble = document.createElement('span');
        bubble.className = 'bubble';
        bubble.innerText = text;
        msg.appendChild(bubble);
        chatMessages.appendChild(msg);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function sendMessage() {
        const text = chatInput.value.trim();
        if (!text) return false;
        appendMessage(text, 'user');
        chatInput.value = '';
        appendMessage('Đang xử lý...', 'bot');
        fetch('<%=request.getContextPath()%>/chatbot?question=' + encodeURIComponent(text))
            .then(res => {
                if (!res.ok) {
                    throw new Error('Phản hồi từ server không thành công: ' + res.status);
                }
                return res.json();
            })
            .then(data => {
                const lastBotMsg = Array.from(chatMessages.getElementsByClassName('msg bot')).pop();
                if (lastBotMsg) lastBotMsg.remove();
                appendMessage(data.answer, 'bot');
            })
            .catch(error => {
                const lastBotMsg = Array.from(chatMessages.getElementsByClassName('msg bot')).pop();
                if (lastBotMsg) lastBotMsg.remove();
                appendMessage('Có lỗi xảy ra: ' + error.message + '. Vui lòng thử lại với câu hỏi cụ thể, ví dụ: "Kiểm tra xe VinFast VF 3".', 'bot');
            });
        return false;
    }
</script>
</body>
</html>