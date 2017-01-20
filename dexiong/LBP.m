function [X,A] = LBP(n, sigma, percent, damp)
% loopy belief propagation for Ising model
% damp is the damping parameter used in message update

if nargin < 3
    percent = 0.5;
    damp = 1;
end


if nargin < 4
    damp = 1;
end

percent = 1-percent;
eta = rand(n,n);
eta(eta>percent) = 1;
eta(eta<=percent) = -1;

% percent = 1 - percent;
messages = rand(n,n,4,2);
% messages()

% eta = 2*eta - 8*sigma;
% sigma = 4*sigma;

T = 200;
A = zeros(1, T);
count = 1;
for t = 1:T
    message = prod(messages, 3);
    m_left = message./messages(:, :, 3, :);
    message_left(:,:,:,1) = exp(-eta+sigma).*m_left(:,:,:,1) + exp(eta-sigma).*m_left(:,:,:,2);
    message_left(:,:,:,2) = exp(-eta-sigma).*m_left(:,:,:,1) + exp(eta+sigma).*m_left(:,:,:,2);
    message_left = [message_left(:, end, :, :), message_left(:, 1:end-1, :, :)];
    
    m_top = message./messages(:, :, 4, :);
    message_top(:,:,:,1) = exp(-eta+sigma).*m_top(:,:,:,1) + exp(eta-sigma).*m_top(:,:,:,2);
    message_top(:,:,:,2) = exp(-eta-sigma).*m_top(:,:,:,1) + exp(eta+sigma).*m_top(:,:,:,2);
    message_top = [message_top(end, :, :, :); message_top(1:end-1, :, :, :)];
    
    m_right = message./messages(:, :, 1, :);
    message_right(:,:,:,1) = exp(-eta+sigma).*m_right(:,:,:,1) + exp(eta-sigma).*m_right(:,:,:,2);
    message_right(:,:,:,2) = exp(-eta-sigma).*m_right(:,:,:,1) + exp(eta+sigma).*m_right(:,:,:,2);
    message_right = [message_right(:, 2:end, :, :), message_right(:, 1, :, :)];
    
    m_bottom = message./messages(:, :, 2, :);
    message_bottom(:,:,:,1) = exp(-eta+sigma).*m_bottom(:,:,:,1) + exp(eta-sigma).*m_bottom(:,:,:,2);
    message_bottom(:,:,:,2) = exp(-eta-sigma).*m_bottom(:,:,:,1) + exp(eta+sigma).*m_bottom(:,:,:,2);
    message_bottom = [message_bottom(2:end, :, :, :); message_bottom(1, :, :, :)];
    
%     
    messages(:,:,1,:) = (1-damp)*messages(:,:,1,:) + damp*message_left;
    messages(:,:,2,:) = (1-damp)*messages(:,:,2,:) + damp*message_top;
    messages(:,:,3,:) = (1-damp)*messages(:,:,3,:) + damp*message_right;
    messages(:,:,4,:) = (1-damp)*messages(:,:,4,:) + damp*message_bottom;
    messages(:,:,1,:) = messages(:,:,1,:)./repmat(sum(messages(:,:,1,:),4), 1,1,1,2);
    messages(:,:,2,:) = messages(:,:,2,:)./repmat(sum(messages(:,:,2,:),4), 1,1,1,2);
    messages(:,:,3,:) = messages(:,:,3,:)./repmat(sum(messages(:,:,3,:),4), 1,1,1,2);
    messages(:,:,4,:) = messages(:,:,4,:)./repmat(sum(messages(:,:,4,:),4), 1,1,1,2);
    
    A(count) = LBP_log_partition(messages, eta, sigma);
    count = count+1;
%     aux = sum(squeeze(prod(messages, 3)),3);
%     aux(10,10, :)
%     messages(:,:,1,1)
end

X = squeeze(prod(messages, 3));
X = exp(eta).*X(:,:,2)./(exp(eta).*X(:,:,2)+exp(-eta).*X(:,:,1));

X = rand(n)<X;