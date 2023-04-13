package com.gsj.webdemo.consumer;

import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author guan.sj
 * @date 2023/4/12
 * @since 1.0
 */
@Slf4j
@Component
@RocketMQMessageListener(topic = "lua-test-topic", consumerGroup = "lua-test-group")
public class TestConsumer implements RocketMQListener<String> {
    private AtomicInteger count = new AtomicInteger(0);

    @Override
    public void onMessage(String s) {
        int i = count.incrementAndGet();
        log.info("receive message: {},{}", s, i);
    }
}
